import hashlib
import os

def compare(a: str, b: str) -> int:
    '''比较两个版本的大小，需要按.分割后比较各个部分的大小 b大则1'''
    lena = len(a.split('.'))  # 获取版本字符串的组成部分
    lenb = len(b.split('.'))
    a2 = a + '.0' * (lenb-lena)  # b比a长的时候补全a
    b2 = b + '.0' * (lena-lenb)
    if(a == b):
        return 0
    else:
        for i in range(max(lena, lenb)):  # 对每个部分进行比较，需要转化为整数进行比较
            if int(a2.split('.')[i]) > int(b2.split('.')[i]):
                return 0
            elif int(a2.split('.')[i]) < int(b2.split('.')[i]):
                return 1
            else:						# 比较到最后都相等，则返回第一个版本
                if i == max(lena, lenb)-1:
                    return 0


def get_md5_01(file_path: str) -> str:
    '''生成 apk md5'''
    md5 = None
    if os.path.isfile(file_path):
        f = open(file_path, 'rb')
        md5_obj = hashlib.md5()
        md5_obj.update(f.read())
        hash_code = md5_obj.hexdigest()
        f.close()
        md5 = str(hash_code).lower()
    else:
        print("There is no file")
    return md5


print(get_md5_01("./build/app/outputs/apk/release/app-release.apk"))
# print(get_md5_01("./build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"))

