import os
import re
from PIL import Image

# Usage
# 把3x的图片放到项目目录的 /assets/3x/ 里面 然后执行脚本就行了

# 转成资源函数字符串
def img2Func(name, size, ext):
    # 下划线转驼峰
    camel = ""
    if isinstance(name, str):
        for i,s in enumerate(name.split("_")):
            camel += (s.capitalize() if i != 0 else s)
    return ("  /// %s\n  static Image %s({Color color, BoxFit fit = BoxFit.cover, double width, double height}) =>\n Image.asset(\"assets/%s%s\", color: color, fit: fit, width: width, height: height);\n\n"%(size, camel, name, ext))

# 项目的路径
projectPath = os.path.abspath(os.path.dirname(__file__))

# assets的路径
assetsPath = projectPath + "/assets/"

path3x = assetsPath + "/3.0x/"

if os.path.exists(path3x)==False:
    print("没找到3x路径")
    exit()

# pubspec.yaml 的路径
pubspecPath = projectPath + "/pubspec.yaml"

pubspec = open(pubspecPath, "r+")
pubspecInfo = pubspec.read()

assetsOld = re.findall(r'assets:.*[pj][pen][g]', pubspecInfo, flags=re.DOTALL)
assetsNew = "assets:\n"

# 图片资源扩展，添加一个获取图片名字的方法
assetsExtNew = """/// 图片资源
extension ImageAssets on Image {

  /// 图片名
  String get name {
    String n = RegExp(r'".+"').stringMatch(this.image.toString());
    return n.length > 2 ? n.substring(1, n.length-1) : "";
  }

"""


for imgName in os.listdir(path3x):
    ext = os.path.splitext(imgName)[-1]
    if ext == ".png" or ext == ".jpg" or ext == ".jpeg":
        img = Image.open(path3x + imgName)
        w, h = img.size
        w2x, h2x = int(w * 0.75), int(h * 0.75)
        # 保存2x图片
        path2x = assetsPath + "/2.0x/"
        if os.path.exists(path2x)==False:
            os.mkdir(path2x)

        img2x = img.resize((w2x, h2x),Image.ANTIALIAS)
        img2x.save(path2x + imgName)

        # # 保存1x图片
        w1x, h1x = int(w * 0.33), int(h * 0.33)
        img = img.resize((w1x, h1x),Image.ANTIALIAS)
        img.save(assetsPath + "/" + imgName)

        # 遍历图片名
        assetsNew += "  - assets/"+ imgName + "\n"

        # 图片名字
        name = os.path.splitext(imgName)[0]

        imgFunc = img2Func(name, ("%d x %d"%(w1x, h1x)), ext)
        assetsExtNew += imgFunc


assetsExtNew += "}\n/// 图片资源 end"

###### 替换 assets 到 pubspec.yaml ######
if len(assetsOld) > 0:
    cmt = re.findall(r'# assets:', pubspecInfo)
    old = assetsOld[0]
    if len(cmt) > 0:
        print("cmt", cmt)
        old = "# " + assetsOld[0]
    new = pubspecInfo.replace(old, assetsNew)
    pubspec.close()
    pubspec = open(pubspecPath, "w+")
    pubspec.write(new)
    pubspec.close()
else:
    pubspec = open(pubspecPath, "a+")
    assetsNew = "\n" + assetsNew
    pubspec.write(assetsNew)
    pubspec.close()


###### 添加到extenion ######

# extension的路径
extPath = projectPath + "/lib/common/extension/image_ext.dart"

extFile = open(extPath, "r+")
extInfo = extFile.read()

assetsExt = re.findall(r'/// 图片资源.+/// 图片资源 end', extInfo, flags=re.DOTALL)


if len(assetsExt) > 0:
    # 更新扩展图片资源函数
    old = assetsExt[0]
    new = extInfo.replace(old, assetsExtNew)
    extFile.close()
    extFile = open(extPath, "w+")
    extFile.write(new)
    extFile.close()
else:
    # 插入扩展资源函数
    extFile = open(extPath, "a+")
    assetsExtNew = "\n" + assetsExtNew
    extFile.write(assetsExtNew)
    extFile.close()