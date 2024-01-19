import streamlit as st 
from PIL import Image

def convert_image(image_path,new_format):
    with Image.open(image_path) as img:

        new_name = image_path.name.split('.')[0]+"."+new_format
        final_path = './'+new_name

        img = img.convert('RGB')
        img.save(final_path)
        st.success('Image saved at'+final_path)

st.title('Image Convertor')
image_file = st.file_uploader('Upload your image',type=['png','jpeg','jpg'])

new_format = st.selectbox('Select the output format',['png','jpeg','jpg'])

if st.button('Convert'):
    if image_file is not None:
        convert_image(image_file,new_format)
    else:
        st.error('Please upload the image file')
