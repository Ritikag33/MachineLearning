import streamlit as st 
from PIL import Image

# Image from Path
st.title('1. Image from Path')
img = Image.open('./Girl1.jpeg')
st.image(img,width=200)

# Image from Link
st.title('2. Image from Link')
st.image('https://cdn.pixabay.com/photo/2022/02/15/07/27/travel-7014427__340.jpg',width=200)

# Video
st.title('3. Video')
video_file = './Rewrite the Stars.mp4'
st.video(video_file,start_time=0)

# Audio
st.title('3. Audio')
audio_file = './Rewrite the Stars.mp3'
st.audio(audio_file)