import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
from tkinter import Toplevel
from tkinter import Label
from tkinter.scrolledtext import ScrolledText
import paramiko
from PIL import ImageTk, Image
from tkinter import Menu
import os 
import subprocess
import sys
import threading
py_path = sys.path[0]

class SSHGui:
    def __init__(self, master):
        # GUI 윈도우 생성
        self.master = master
        self.master.title('클라우드 환경 취약점 진단 도구 v1.5')
        self.master.resizable(False, False)
        main_frame = ttk.Frame(self.master, padding=20)
        main_frame.grid()


        # 로고 이미지 로드
        logo_image = Image.open("logo.png")
        logo_image = logo_image.resize((80, 80), Image.ANTIALIAS)
        JBlogo_image = Image.open("JBULOGO.png")
        JBlogo_image = JBlogo_image.resize((80, 80), Image.ANTIALIAS)
        self.logo_photo = ImageTk.PhotoImage(logo_image)
        self.JBlogo_photo = ImageTk.PhotoImage(JBlogo_image)

        # 로고 표시
        logo_label = ttk.Label(main_frame, image=self.logo_photo)
        logo_label.place(x=530, y=17)
        JBlogo_label = ttk.Label(main_frame, image=self.JBlogo_photo)
        JBlogo_label.place(x=530, y=120)
        # self.execute_btn.place(x=370, y=153)

        # 호스트 정보 입력 폼
        ssh_frame = ttk.LabelFrame(main_frame, text='SSH 정보', padding=10)
        ssh_frame.grid(row=1, column=0, columnspan=2, padx=5, pady=5, sticky='w')

        ttk.Label(ssh_frame, text='IP 주소').grid(row=0, column=0, padx=5, pady=5, sticky='w')
        ttk.Label(ssh_frame, text='포트 번호').grid(row=1, column=0, padx=5, pady=5, sticky='w')
        ttk.Label(ssh_frame, text='사용자 이름').grid(row=2, column=0, padx=5, pady=5, sticky='w')
        ttk.Label(ssh_frame, text='SSH 비밀번호').grid(row=3, column=0, padx=5, pady=5, sticky='w')
        ttk.Label(ssh_frame, text='MySQL 비밀번호').grid(row=4, column=0, padx=5, pady=5, sticky='w')

        self.host_entry = ttk.Entry(ssh_frame)
        self.host_entry.grid(row=0, column=1, padx=5, pady=5, sticky='w')

        self.port_entry = ttk.Entry(ssh_frame)
        self.port_entry.grid(row=1, column=1, padx=5, pady=5, sticky='w')

        self.username_entry = ttk.Entry(ssh_frame)
        self.username_entry.grid(row=2, column=1, padx=5, pady=5, sticky='w')

        self.password_entry = ttk.Entry(ssh_frame, show='*')
        self.password_entry.grid(row=3, column=1, padx=5, pady=5, sticky='w')

        self.mysqlPassword_entry = ttk.Entry(ssh_frame, show='*', state='disabled')
        self.mysqlPassword_entry.grid(row=4, column=1, padx=5, pady=5, sticky='w')

        # 체크박스
        checkbox_frame = ttk.LabelFrame(main_frame, text='진단 항목', padding=10)
        checkbox_frame.grid(row=1, column=1, columnspan=2, padx=5, pady=5, sticky='w')

        self.check_openstack_var = tk.BooleanVar(value=False)
        self.check_openstack = ttk.Checkbutton(checkbox_frame, text='OpenStack', variable=self.check_openstack_var)
        self.check_openstack.grid(row=0, column=0, padx=5, pady=5, sticky='w')

        self.check_linux_var = tk.BooleanVar(value=False)
        self.check_linux = ttk.Checkbutton(checkbox_frame, text='Linux', variable=self.check_linux_var)
        self.check_linux.grid(row=0, column=1, padx=5, pady=5, sticky='w')

        self.check_apache_var = tk.BooleanVar(value=False)
        self.check_apache = ttk.Checkbutton(checkbox_frame, text='Apache', variable=self.check_apache_var)
        self.check_apache.grid(row=1, column=0, padx=5, pady=5, sticky='w')

        self.check_docker_var = tk.BooleanVar(value=False)
        self.check_docker = ttk.Checkbutton(checkbox_frame, text='Docker', variable=self.check_docker_var)
        self.check_docker.grid(row=1, column=1, padx=5, pady=5, sticky='w')

        self.check_mysql_var = tk.BooleanVar(value=False)
        self.check_mysql = ttk.Checkbutton(checkbox_frame, text='MySQL', variable=self.check_mysql_var, command=self.on_mysql_checkbox_change)
        self.check_mysql.grid(row=2, column=0, padx=5, pady=5, sticky='w')

        # 실행 버튼
        self.execute_btn = ttk.Button(main_frame, text='진단 실행', command=self.execute)
        # self.execute_btn.grid(row=1, column=2, columnspan=2, padx=5, pady=5)
        self.execute_btn.place(x=318, y=180)
        self.folder_btn = ttk.Button(main_frame, text='보고서 열기', command=self.folder)
        self.folder_btn['state'] = tk.DISABLED
        # self.execute_btn.grid(row=1, column=2, columnspan=2, padx=5, pady=5)
        self.folder_btn.place(x=413, y=180)
        # 실행 결과 출력
        output_frame = ttk.LabelFrame(main_frame, text='실행 결과', padding=10)
        output_frame.grid(row=3, column=0, columnspan=2, padx=5, pady=5, sticky='w')

        self.output_text = ScrolledText(output_frame, height=10)
        self.output_text.grid(row=0, column=0, padx=5, pady=5, sticky='w')

        # 보고서 파일 다운로드
        report_frame = ttk.LabelFrame(main_frame, text='Made by 정보는 역시 심정보', padding=10)
        report_frame.grid(row=4, column=0, columnspan=2, padx=5, pady=5, sticky='w')

        # 메뉴바 생성
        self.create_menu()

    def create_menu(self):
        # 메뉴바 생성
        menu_bar = Menu(self.master)
        self.master.config(menu=menu_bar)

        help_menu = Menu(menu_bar, tearoff=0)
        menu_bar.add_cascade(label='Menu', menu=help_menu)

        # 메뉴 아이템 생성
        help_menu.add_command(label='Help', command=self.show_help)
        help_menu.add_command(label='About Us', command=self.show_about)

    def show_about(self):
        messagebox.showinfo('About', '')

    def show_help(self):
        messagebox.showinfo('Help', 'KISA의 클라우드 환경 진단 가이드에 따라, 자동 진단을 수행하는 도구입니다.\n\n1. 방화벽 허용 IP를 ip_port.csv에 작성하세요.\n2. 진단 시스템의 SSH 정보를 입력하세요.\n3. 진단 항목을 선택하고 "진단 실행" 버튼을 누르세요.\n4. 진단이 끝나면 보고서 열기 버튼을 누르세요.')


    def execute(self):
        # 진행 중에 "wait" 커서로 진행
        self.master.configure(cursor="wait")

        # 호스트 정보 가져오기
        host = self.host_entry.get()
        port = self.port_entry.get()
        username = self.username_entry.get()
        password = self.password_entry.get()
        mysqlPwd = self.mysqlPassword_entry.get()

        # SSH 접속
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            ssh.connect(host, port, username, password)
        except:
            messagebox.showerror('에러', 'SSH 접속에 실패하였습니다.')
            ssh.close()
            return

        # 체크박스 선택에 따라 실행할 스크립트 결정
        scripts = []
        if self.check_openstack_var.get():
            scripts.append('bash openstack.sh')
        if self.check_linux_var.get():
            scripts.append('bash linux.sh')
        if self.check_apache_var.get():
            scripts.append('bash apache.sh')
        if self.check_docker_var.get():
            scripts.append('bash docker.sh')
        if self.check_mysql_var.get():
            scripts.append('bash mysql.sh' + ' ' + mysqlPwd)

        # 스크립트 전송 및 실행
        def run_scripts():
            try:
                remotepath = 'script.tar'
                localpath = 'script.tar'
                sftp = ssh.open_sftp()
                sftp.put(localpath, remotepath)
                remotepath = 'ip_port.csv'
                localpath = 'ip_port.csv'
                sftp = ssh.open_sftp()
                sftp.put(localpath, remotepath)
                execCmd = 'tar -xvf script.tar'
                (stdin, stdout, stderr) = ssh.exec_command(execCmd)
                output = stdout.readlines()

                self.output_text.delete('1.0', tk.END)  # 이전 출력 내용 삭제

                for script in scripts:
                    cmd = f'cd script && sudo {script}'
                    (stdin, stdout, stderr) = ssh.exec_command(cmd)
                    output = stdout.readlines()           
                    self.output_text.insert(tk.END, f"\nOutput of {script}:\n")
                    for line in output:
                        self.output_text.insert(tk.END, line)
                        self.output_text.see(tk.END)
                sftp.close()
                # messagebox.showinfo('완료', '스크립트 실행이 완료되었습니다.')
            except:
                messagebox.showerror('에러', '스크립트 실행에 실패하였습니다.')
                ssh.close()
                return

            # 보고서 파일 다운로드
            try:
                sftp = ssh.open_sftp()
                if self.check_linux_var.get():
                    self.output_text.insert(tk.END, f"linux report downloading...\n")
                    self.output_text.see(tk.END)
                    src1 = './script/linux_report.csv'
                    dest1 = f'./backend/vulscan_csv/linux_report.csv'
                    sftp.get(src1, dest1)
                    subprocess.run(['python', './backend/linux/linux_report.py'])
                    subprocess.run(['python', './backend/linux/linux_graph.py'])
                    subprocess.run(['python', './backend/linux/linux_result.py'])
                if self.check_apache_var.get():
                    self.output_text.insert(tk.END, f"apache_report downloading...\n")
                    self.output_text.see(tk.END)
                    src2 = './script/apache_report.csv'
                    dest2 = f'./backend/vulscan_csv/apache_report.csv'
                    sftp.get(src2, dest2)
                    subprocess.run(['python', './backend/apache/apache_report.py'])
                    subprocess.run(['python', './backend/apache/apache_graph.py'])
                    subprocess.run(['python', './backend/apache/apache_result.py'])
                if self.check_docker_var.get():
                    self.output_text.insert(tk.END, f"docker_report downloading...\n")
                    self.output_text.see(tk.END)
                    src3 = './script/docker_report.csv'
                    dest3 = f'./backend/vulscan_csv/docker_report.csv'
                    sftp.get(src3, dest3)
                    subprocess.run(['python', './backend/docker/docker_report.py'])
                    subprocess.run(['python', './backend/docker/docker_graph.py'])
                    subprocess.run(['python', './backend/docker/docker_result.py'])
                if self.check_mysql_var.get():
                    self.output_text.insert(tk.END, f"mysql_report downloading...\n")
                    self.output_text.see(tk.END)
                    src4 = './script/my-sql_report.csv'
                    dest4 = f'./backend/vulscan_csv/mysql_report.csv'
                    sftp.get(src4, dest4)
                    subprocess.run(['python', './backend/mysql/mysql_report.py'])
                    subprocess.run(['python', './backend/mysql/mysql_graph.py'])
                    subprocess.run(['python', './backend/mysql/mysql_result.py'])
                if self.check_openstack_var.get():
                    self.output_text.insert(tk.END, f"openstack_report downloading...\n")
                    self.output_text.see(tk.END)
                    src4 = './script/openstack_report.csv'
                    dest4 = f'./backend/vulscan_csv/openstack_report.csv'
                    sftp.get(src4, dest4)
                    subprocess.run(['python', './backend/openstack/openstack_report.py'])
                    subprocess.run(['python', './backend/openstack/openstack_graph.py'])
                    subprocess.run(['python', './backend/openstack/openstack_result.py'])
                sftp.close()
            except:
                messagebox.showerror('에러', '보고서 파일 다운로드에 실패하였습니다.')

            # 점검용 파일 제거 후 SSH 접속 종료
            delCmd = 'rm -f -r script script.tar ip_port.csv'
            stdin, stdout, stderr = ssh.exec_command(delCmd)
            output = stdout.readlines()

            messagebox.showinfo('완료', '취약점 진단이 완료되었습니다. 보고서를 확인하세요.')
            self.folder_btn['state'] = tk.NORMAL

            self.master.configure(cursor="arrow")
            ssh.close()

        script_thread = threading.Thread(target=run_scripts)
        script_thread.start()    



    def folder(self):
        os.startfile("report")
    def on_mysql_checkbox_change(self):
        if self.check_mysql_var.get():
            self.mysqlPassword_entry['state'] = tk.NORMAL
        else:
            self.mysqlPassword_entry['state'] = tk.DISABLED
    def show_about(self):
        about_window = Toplevel(self.master)
        about_window.title('About')
        
        # 이미지 로드
        about_image = Image.open("./about_image.png")
        about_image = about_image.resize((500, 500), Image.ANTIALIAS)
        self.about_photo = ImageTk.PhotoImage(about_image)
        
        # 이미지 표시
        image_label = Label(about_window, image=self.about_photo)
        image_label.pack()


root = tk.Tk()
app = SSHGui(root)
root.mainloop()
