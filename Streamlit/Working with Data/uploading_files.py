import pandas as pd 
import streamlit as st 
from PIL import Image

st.title('File Uploading')

# 1. Image 
st.subheader('1. Uploading an Image')
img_file = st.file_uploader('Upload your image',type=['png','jpg','jpeg'])
if img_file is not None:
    file_details = {'file_name':img_file.name,'file_type':img_file.type,
                    'file_size':img_file.size}

    st.write(file_details)
    st.image(Image.open(img_file))

# 2. Audio 
st.subheader('1. Uploading an Audio')
audio_file = st.file_uploader('Upload your audio',type=['wav','mp3'])
if audio_file is not None:
    file_details = {'file_name':audio_file.name,'file_type':audio_file.type,
                    'file_size':audio_file.size}

    st.write(file_details)
    st.audio(audio_file)

# 3. Video 
st.subheader('1. Uploading a Video')
video_file = st.file_uploader('Upload your video',type=['mov','mp4'])
if video_file is not None:
    file_details = {'file_name':video_file.name,'file_type':video_file.type,
                    'file_size':video_file.size}

    st.write(file_details)
    st.video(video_file)

# 4. CSV
st.subheader('1. Uploading a CSV')

df = st.file_uploader("Loading the CSV file:",type=['csv','xlsx'])
if df is not None:
    data = pd.read_csv(df)

    # Display the DataFrame
    st.table(data.head())