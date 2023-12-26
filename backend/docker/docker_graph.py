import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
from matplotlib.backends.backend_pdf import PdfPages
import sys

matplotlib.rcParams['font.family'] = 'Malgun Gothic' # windows
# matplotlib.rcParmas['font.family'] = 'AppleGothic' # mac
matplotlib.rcParams['font.size'] = 9 # 글자크기
matplotlib.rcParams['axes.unicode_minus'] = False # 한글폰트 사용시 마이너스 글자가 깨지는 현상을 해결

py_path = sys.path[0]
df = pd.read_csv(py_path+'/../vulscan_csv/docker_report.csv')
graph_path = py_path+'/../output/docker_graph.pdf'

df.fillna('N/A', inplace=True)
# 색상 설정
colors = ['#caffbf', '#ffadad', '#ffd6a5']

labels= ['양호', '취약', '점검 불가']

# 계정관리 항목의 점검결과 계산
result1 = df[df['구분'] == 'Host설정']['점검결과'].value_counts()
result1 = result1.reindex(['양호', '취약', '점검 불가'], fill_value=0)

# 파일 및 디렉토리 관리의 점검결과 계산
result2 = df[df['구분'] == '도커 데몬 설정']['점검결과'].value_counts()
result2 = result2.reindex(['양호', '취약', '점검 불가'], fill_value=0)

# 서비스 관리 항목의 점검결과 계산
result3 = df[df['구분'] == '도커 데몬 설정 파일']['점검결과'].value_counts()
result3 = result3.reindex(['양호', '취약', '점검 불가'], fill_value=0)

# 컨테이너 이미지 및 빌드 파일
result4 = df[df['구분'] == '컨테이너 이미지 및 빌드 파일']['점검결과'].value_counts()
result4 = result4.reindex(['양호', '취약', '점검 불가'], fill_value=0)

# 컨테이너 런타임
result5 = df[df['구분'] == '컨테이너 런타임']['점검결과'].value_counts()
result5 = result5.reindex(['양호', '취약', '점검 불가'], fill_value=0)


# 원그래프 데이터 계산
result6 = df['점검결과'].value_counts()
result6 = result6.reindex(['양호', '취약'], fill_value=0)

with PdfPages(graph_path) as pdf:
    # 막대그래프 그리기
    fig ,ax = plt.subplots(2, 3, figsize=(8.27, 11.69))
    
    # Plot for Host설정
    ax[0, 0].bar(result1.index, result1.values, color=colors, label=labels)
    ax[0, 0].set_title('Host설정')
    ax[0, 0].set_ylim([0, 12])

    # Plot for 도커 데몬 설정
    ax[0, 1].bar(result2.index, result2.values, color=colors)
    ax[0, 1].set_title('도커 데몬 설정')
    ax[0, 1].set_ylim([0, 12])

    # Plot for 도커 데몬 설정 파일
    ax[0, 2].bar(result3.index, result3.values, color=colors)
    ax[0, 2].set_title('도커 데몬 설정 파일')
    ax[0, 2].set_ylim([0, 12])
    
    # Plot for 컨테이너 이미지 및 빌드 파일
    ax[1, 0].bar(result4.index, result4.values, color=colors)
    ax[1, 0].set_title('컨테이너 이미지 및 빌드 파일')
    ax[1, 0].set_ylim([0, 12])

    # Plot for 컨테이너 런타임
    ax[1, 1].bar(result5.index, result5.values, color=colors)
    ax[1, 1].set_title('컨테이너 런타임')
    ax[1, 1].set_ylim([0, 12])
    
    # 원그래프 그리기
    wedges, _, autotexts = ax[1, 2].pie(
        result6, labels=result6.index, colors=colors, autopct='%1.1f%%', startangle=90)
    ax[1, 2].set_title('docker 진단 결과')
    ax[1, 2].axis('equal')  # 원을 원형으로 보이게 함
    


#Remove the empty subplot
    #fig.delaxes(ax[1, 2])

    plt.suptitle('docker 취약점 진단 점검 결과', fontsize=25, fontweight='bold', x=0.5, y=0.95)
    
    fig.subplots_adjust(top=0.8, bottom=0.08 ,hspace=0.3, wspace=0.3)
    
    legend_font_size = 12
    fig.legend(labels, loc='center', bbox_to_anchor=(0.5, 0.87), ncol=len(labels))

    pdf.savefig()
    plt.close()