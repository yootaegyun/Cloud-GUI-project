import win32com.client
import sys
from datetime import datetime
now = datetime.now()
date = now.strftime('%Y-%m-%d_%H-%M-%S')

excel = win32com.client.Dispatch("Excel.Application")
excel.Visible = False

from PyPDF2 import PdfMerger

pdf_merger = PdfMerger()
py_path = sys.path[0]
pdf_files = [py_path+"/../output/linux_report.pdf",
             py_path+"/../output/linux_graph.pdf"]

for pdf_file in pdf_files:
    pdf_merger.append(pdf_file)

output_path = py_path+"/../../report/linux_result_"+date+".pdf"
pdf_merger.write(output_path)
pdf_merger.close()