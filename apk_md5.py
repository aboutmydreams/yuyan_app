import hashlib
import os


def get_md5_01(file_path):
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
