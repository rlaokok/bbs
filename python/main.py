from flask import Flask, render_template, request,session, redirect, json
import pymysql
from board import Board
from datetime import timedelta
import os
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import re
import time

from urllib.request import urlopen
from konlpy.tag import Okt
from collections import Counter
from PIL import Image
import numpy as np

from pymongo import MongoClient
import datetime

import threading

def mongoColl():
    conn = MongoClient()
    db = conn.test
    coll = db.collection
    return coll

def thread():
    while True:
        minute = datetime.datetime.now().strftime("%M%S")
        if int(minute) == 0:
            conn = MongoClient()
            db = conn.test
            coll = db.collection

            print("*-----------------------upload start-----------------------*")
            PATH = os.path.dirname(__file__)
            driver_path = os.path.join(PATH, "chromedriver.exe")
            options = webdriver.ChromeOptions()
            options.add_argument("headless")
            driver = webdriver.Chrome(driver_path, options=options)
            driver.implicitly_wait(10)
            url = "https://news.naver.com/main/ranking/popularDay.nhn?mid=etc&sid1=111"
            driver.get(url)
            time.sleep(2)
            copyright = "저작권"
            get_news = []
            for i in range(0, 45):
                driver.find_elements_by_css_selector(".rankingnews_list > li > .list_content > .list_title")[
                    i].click()
                time.sleep(0.1)
                contents = driver.find_element_by_css_selector("#articleBodyContents").text
                a = driver.find_element_by_css_selector("#articleBodyContents a").text
                obj = re.search(copyright, contents)
                time.sleep(0.1)
                driver.back()
                time.sleep(0.1)
                time.sleep(0.1)
                if obj != None:
                    get_news.append(contents[:obj.start()].replace("▶", "").replace("◀","").replace("■" ,"").replace("◆", ""))
                else:
                    get_news.append(contents[:contents.find(a)].replace("▶", "").replace("◀","").replace("■" ,"").replace("◆", ""))
            yearMonthDay_Hour = datetime.datetime.now().strftime("%y.%m.%d-%H:%M")
            post = {'DATE': yearMonthDay_Hour, 'words' : get_news}
            coll.insert(post)
            print("*-----------------------upload end-----------------------*")


p = threading.Thread(target=thread)
p.start()

app = Flask(__name__)
app.config['SECRET_KEY']='This is secret key'
app.config['PERMANENT_SESSION_LIFETIME'] =  timedelta(minutes=100)


@app.route('/selenium', methods=['GET', 'POST'])
def selenium():
    coll = mongoColl()
    date_list = []
    for date in coll.find():
        if date['DATE'] not in date_list:
            date_list.append(date['DATE'])
    print(date_list)
    return render_template("selenium.html", date_list=date_list)

@app.route('/get_news', methods=['GET', 'POST'])
def get_news():
    # -*- encoding: utf-8 -*-
    data = request.form['select']
    coll = mongoColl()
    news_content = coll.find({"DATE": data}, {'_id': 0})[0]['words']
    return json.dumps({"data":news_content})


@app.route('/img_test', methods=['GET', 'POST'])
def img_test():
    if request.method =='GET':
        return render_template("selenium.html")
    if request.method == 'POST':
        PATH = os.path.dirname(__file__)
        mask_name = request.form  # 데이터 받는부분
        suffix = mask_name['date'][:-3]
        img_path = f"static/img/{mask_name['img_name']}_{suffix}_test.png"
        print(mask_name)
        import codecs
        if mask_name['img_name'] == "human" or mask_name['img_name'] == "dog" \
            or mask_name['img_name'] == "bird":
            if not os.path.exists(os.path.join(PATH, img_path)):
                text = mask_name['textarea']
                if not text:
                    return json.dumps({"noData":"no"})
                else:
                    okt = Okt()
                    morphs = [okt.pos(text)]
                    tags = []
                    words = []

                    for morph in morphs:
                        for word, tag in morph:
                            if tag in ["Noun", "verb", "Adjective", "Number"] and ('것' not in word) \
                                    and ('이' not in word) and ('약' not in word) and ("고" not in word) and \
                                    ("등" not in word) and ("있다" not in word) and ("수" not in word) \
                                    and ("뎌" not in word) and ("기자" not in word):
                                words.append(word)
                                tags.append(tag)

                    count = Counter(words)
                    test_words = dict(count.most_common())
                    from matplotlib import pyplot as plt
                    import matplotlib
                    matplotlib.use('agg')
                    from wordcloud import WordCloud, ImageColorGenerator
                    import nltk  # 자연어 처리 Natural Language Toolkit  http://www.nltk.org/
                    from nltk.corpus import stopwords

                    mask = np.array(Image.open(os.path.join(PATH, f"static/img/{mask_name['img_name']}.png")))
                    image_color = ImageColorGenerator(mask)
                    wordcloud = WordCloud(font_path='C:/Windows/Fonts/malgun.ttf',
                                          background_color='white', colormap="Accent_r",
                                          mask=mask,  color_func=image_color,   #lambda *args, **kwargs: "black",
                                          width=1500, height=1000).generate_from_frequencies(test_words)

                    if not os.path.exists(os.path.join(PATH, img_path)):
                        plt.imshow(wordcloud.recolor(color_func=image_color), interpolation="bilinear")
                        plt.axis('off')
                        plt.savefig(os.path.join(PATH, img_path))
                        plt.close()
                        img_path2 = img_path
                    else:
                        img_path2 = img_path
                    return json.dumps(str(img_path2))
            else:
                return json.dumps(str(img_path))


@app.route('/canvas', methods=["GET","POST"])
def canvas():
    return render_template('canva.html')

# plt 방법 하지만 중복에러
@app.route('/canvas/save', methods=["GET","POST"])
def canvas_save():
    from io import BytesIO
    import base64
    import cv2 as cv
    import io
    import random
    file = request.form['data']
    starter = file.find(',')
    print(file)
    image_data = file[starter + 1:]

    img = Image.open(BytesIO(base64.b64decode(image_data)))

    if os.path.isfile('static/img/img.png'):
        os.remove('static/img/img.png')
    from matplotlib import pyplot as plt
    import matplotlib
    matplotlib.use('agg')
    fig = plt.imshow(img)
    plt.axis('off')
    fig.axes.get_xaxis().set_visible(False)
    fig.axes.get_yaxis().set_visible(False)
    plt.savefig('static/img/img.png', bbox_inches='tight')

    test = cv.imread('static/img/img.png')
    # cv.imshow('test', test)
    # cv.waitKey(0)
    test2 = cv.resize(test, (28, 28))
    print(test2.shape)
    img_array = test2.reshape(1, 28, 28, 3)
    print(img_array.shape)

    from keras.preprocessing.image import load_img, img_to_array
    from keras.models import load_model
    from keras.backend import clear_session

    #비교 분석
    csv_file_path = 'label_image_map.csv'
    path = os.path.dirname(__file__)
    lables_file = os.listdir(os.path.join(path, "phd08_png_results"))
    csv_file = io.open(csv_file_path, 'r', encoding='utf-8')

    label_dict = {}
    count = 0

    for label in lables_file:
        label_dict[label] = count
        count += 1

    filenames = []
    labels = []

    for row in csv_file:
        path, label = row.strip().split(',')
        filenames.append(path)
        labels.append(label_dict[label])


    seed = 1998

    shuffled_indices = list(range(len(filenames)))
    random.seed(seed)
    random.shuffle(shuffled_indices)
    filenames = [filenames[i] for i in shuffled_indices]
    labels = [labels[i] for i in shuffled_indices]
    print("List shuffle finished")
    clear_session()
    model = load_model('model_new_210209.h5')
    pred = model.predict(img_array)
    pred = np.argmax(pred, axis=1)
    for key, value in label_dict.items():
        if value == pred:
            print(key)
            print(pred)
            juju = {'data': key}
    return json.dumps(juju)


@app.route("/r_learning", methods=["GET", "POST"])
def game():
    return render_template('game.html')

@app.route("/natural_language_change", methods=["GET", "POST"])
def natural_language_change():
    data = request.form['textarea']
    print(data)
    morphs = []
    okt = Okt()

    morphs.append(okt.pos(data))

    tags = []
    words = []

    for morph in morphs:
        for word, tag in morph:
            if tag in ["Noun", "verb", "Adjective", "Number"] and ('것' not in word) \
                    and ('이' not in word) and ('약' not in word) and ("고" not in word) and \
                    ("등" not in word) and ("있다" not in word) and ("수" not in word) \
                    and ("뎌" not in word) and ("기자" not in word):
                words.append(word)
                tags.append(tag)
    count = Counter(words)
    test_words = dict(count.most_common())
    print(test_words)
    sorted_word = sorted(test_words.items(), key=lambda x: x[1], reverse=True)
    print(sorted_word)
    #return json.dumps({"words":wordscount})
    return json.dumps({"sorted_word": sorted_word})