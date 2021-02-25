import PIL.Image as Image
import numpy as np
# sudo python3 -m pip install --upgrade scikit-image
img = Image.open('./assets/images/guide/guide1.jpg')
mode = np.array(img)


def to_png(mode):
    new_img_array = []
    for i, row in enumerate(mode):
        new_row = []
        for r in row:
            if sum(list(r)) < 20:
                new_row.append([54, 63, 58])
            # elif (sum(list(r)) >= 15) & (sum(list(r)) <= 45):
            #     n_r = list(r)
            #     n_r.append(int(sum(list(r))))
            #     new_row.append(n_r)
            else:
                n_r = list(r)
                # n_r.append(255)
                new_row.append(n_r)
        new_img_array.append(new_row)

    new_img_array_mode = np.array(new_img_array)
    return new_img_array_mode


def mode_to_img(mode):
    array_mode = np.array(mode).astype('uint8')
    image = Image.fromarray(array_mode).convert('RGB')
    return image


new_img_array_mode = to_png(mode)
img = mode_to_img(new_img_array_mode)
img.save('./assets/images/guide/guide1111.jpg')
# img = Image.open('./assets/images/guide/guide11.png')
# mode = np.array(img)
# print(mode[200])
