"""
    Predicts user's personaility type based on their response from the onboarding questions
"""

"""
Steps for this project
    1. dataset
    2. date preprocessing
    a. add new columns (I/E, I/S, F/T, P/J)
    b. removal of unesscary data point
    b1. url links removed
    b2. remove stopwords
    b3. lemmatization
    b4. tokenization using keras word tokenizer
    3. data training
    4. classfication [tensorflow]
"""

from sklearn.model_selection import GridSearchCV
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.metrics import classification_report
from sklearn.svm import SVC
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import metrics
import sklearn
import pandas as pd
import re
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()
nltk.download('wordnet')


def readDatFrame():

    # open csv file
    myersBrigs_df = pd.read_csv(
        "/Users/sanzi/Desktop/school/personality dating app/datingapp/machine algo/mbti_1.csv")
    # print(myersBrigs_df)

    myersBrigs_df["processed posts"] = myersBrigs_df["posts"].str.lower()

    return myersBrigs_df

# Add 4 new columns for the following
# First Column: Introvert / Extrovert
# Second Column: Intution / Sensation
# Third Column: Thinking / Feeling
# Fourth Column: Perception / Judgement


# Create a matrix column that classifiers how many 1 or 0 there are for each columns
def personailityColumns_helper(matrixList, columnIndiciator, personailityList, matrixIndicator):

    index = 0
    # Loop through each value in the personaliltyList
    for word in personailityList:
        # For each character in the personaility type word
        if word[matrixIndicator] == columnIndiciator:
            matrixList[index] = 1
        # else if the character does not match the one we are looking for set it as 0
        else:
            matrixList[index] = 0

        # increment index by 1
        index += 1
    # return the matrix list
    return matrixList


# Add the personailty column to the dataframe
def personailtyColumns(dataframe):

    E_I = np.zeros(dataframe.shape[0])
    I_S = np.zeros(dataframe.shape[0])
    T_F = np.zeros(dataframe.shape[0])
    P_J = np.zeros(dataframe.shape[0])

    personailityType_list = list(dataframe["type"])

    E_I = personailityColumns_helper(E_I, "E", personailityType_list, 0)
    I_S = personailityColumns_helper(I_S, "S", personailityType_list, 1)
    T_F = personailityColumns_helper(T_F, "F", personailityType_list, 2)
    P_J = personailityColumns_helper(P_J, "J", personailityType_list, 3)

    # If they are an extrovert value in this column is a 1
    dataframe.insert(2, "Extrovert/Introvert", E_I, True)

    # If they are an sensational value in this column is a 1
    dataframe.insert(3, "Intution/Sensation", I_S, True)

    # If they are an feeling value in this column is a 1
    dataframe.insert(4, "Thinking/Feeling", T_F, True)

    # If they are an judgement value in this column is a 1
    dataframe.insert(5, "Perception/Judgement", P_J, True)


"""

remove unneccasry infomation from the posts at each index:
    - stopwords
    - url links
    - special characters and numbers
    - user that have the 16 personlity type in their text
    - spaces
"""


def removalUrl(dataframe):

    # all the patterns we would like to find and remove
    pattern1 = re.compile(r' http://\S+|https://\S+')
    pattern2 = re.compile(r'http[s]?://\S+')
    pattern3 = re.compile(r"http\S+")

    # loop through the dataframe by getting the shape of the dataframe, the number or rows and columns
    for i in range(dataframe.shape[0]):

        # get the post text at the selected index
        text = dataframe._get_value(i, 'processed posts')
        # print(pre_text)

        # find the string that matches the pattern and replace with an empty string
        post_text = re.sub(pattern1, ' ', text)
        post_text = re.sub(pattern2, ' ', text)
        post_text = re.sub(pattern3, ' ', text)

        # set the post text to the processed post column
        dataframe._set_value(i, 'processed posts', post_text)


def removalSpecial(dataframe):
    pattern3 = re.compile('\W+')
    pattern4 = re.compile(r'[0-9]')
    pattern5 = re.compile(r'[_+]')
    pattern6 = re.compile('\s+')

    # loop through the dataframe by getting the shape of the dataframe, the number or rows and columns
    for i in range(dataframe.shape[0]):

        # get the post text at the selected index
        pre_text2 = dataframe._get_value(i, 'processed posts')

        # find the string that matches the pattern and replace with an empty string
        post_text2 = re.sub(pattern3, ' ', pre_text2)
        post_text2 = re.sub(pattern4, ' ', post_text2)
        post_text2 = re.sub(pattern5, ' ', post_text2)
        post_text2 = re.sub(pattern6, ' ', post_text2)

        # set the post text to the processed post column
        dataframe._set_value(i, 'processed posts', post_text2)


def removalStopWords(dataframe):
    stopwordsList = stopwords.words('english')
    # removal of the stop words
    for i in range(dataframe.shape[0]):
        post_text_with_stopwords = dataframe._get_value(
            i, 'processed posts')
        post_text_without_stopwords = " ".join(
            [w for w in post_text_with_stopwords.split(' ') if w not in stopwordsList])
        dataframe._set_value(i, "processed posts",
                             post_text_without_stopwords)


def removalPersonalilty(dataframe):
    pattern7 = ['infp', 'infj', 'intp', 'intj',
                'entp', 'enfp', 'istp', 'isfp',
                'entj', 'istj', 'enfj', 'isfj',
                'estp', 'esfp', 'esfj', 'estj']

    # removal of the 16 personality types from the texts
    for i in range(dataframe.shape[0]):
        text = dataframe._get_value(i, "processed posts")
        updated_text = " ".join(
            [words for words in text.split(' ') if words not in pattern7])
        dataframe._set_value(i, "processed posts", updated_text)


def lemmatization(dataframe):
    for i in range(dataframe.shape[0]):
        text = dataframe._get_value(i, 'processed posts')
        lemmatized_text = " ".join([lemmatizer.lemmatize(w)
                                   for w in text.split(' ')])
        dataframe._set_value(i, 'processed posts', lemmatized_text)


def dataPreprocessing(frame):
    removalUrl(frame)
    removalSpecial(frame)
    removalStopWords(frame)
    removalPersonalilty(frame)
    lemmatization(frame)


# Using CountVectorizer we are converting the posts into a matrix


def setProcessList(myersBrigs_df):
    # list holding the verctorized processed posts
    processedPosts_list = []

    # loop through every item for processed posts and append to the list
    # i is the index value of the table and j is the processed posts text
    for i, j in myersBrigs_df["processed posts"].iteritems():

        # print("The value of I is: ")
        # print(i)

        # print("The value of J is: ")
        # print(j)

        # append the processed list text in the list
        processedPosts_list.append(j)

    return processedPosts_list


def vectorization(input, dataframe):
    # Take the processed post list and convert it to  count vector matrix
    vector = CountVectorizer(stop_words="english", max_features=1500)
    vector_features = vector.fit_transform(input)
    # print(vector)
    # print(vector_features)

    # incorporate tf-idf to add weight to the importat words in all processed posts and vectorize it into a matrix
    tf = TfidfTransformer()
    tf_vector = tf.fit_transform(vector_features).toarray()
    X_data = tf_vector

    # Classify what the Y_Data would be which is the processed_posts, introvert/extrovert, intution/sensation, thinking/feeling, perception/judgement
    Y_data = dataframe.iloc[:, 2:6]

    return X_data, Y_data


# Function to analysis each prediction model
'''
To view how accurate a model is at prediciting we will be outputs the classfication report for the given model
It will take in all the 4 models: Introvert/Extrovert, Intution/Sensation, Thinking/Feeling, Judging/Perceiving
And compute the following: accuracy, recall, and f1 score
'''


def classifcation_Report(predictionModel_EI, predictionModel_IS, predictionModel_TF, predictionModel_JP, Y_test_IE, Y_test_NS, Y_test_TF, Y_test_JP):

    print("Classification Report for Extrovert and Introvert: ")
    print(classification_report(Y_test_IE, predictionModel_EI))
    acurracy_EI = accuracy_score(Y_test_IE, predictionModel_EI)
    print("Accuracy for Report for Extrovert/Introver: ", acurracy_EI, "\n")
    print("----------------------------------------------")

    print("Classification Report for Intution and Sensation: ")
    print(classification_report(Y_test_NS, predictionModel_IS))
    acurracy_IS = accuracy_score(Y_test_NS, predictionModel_IS)
    print("Accuracy for Report for Extrovert/Introver: ", acurracy_IS, "\n")
    print("----------------------------------------------")

    print("Classification Report for Thinking and Feeling: ")
    print(classification_report(Y_test_TF, predictionModel_TF))
    acurracy_TF = accuracy_score(Y_test_TF, predictionModel_TF)
    print("Accuracy for Report for Extrovert/Introver: ", acurracy_TF, "\n")
    print("----------------------------------------------")

    print("Classification Report for Judgement and Perceiving: ")
    print(classification_report(Y_test_JP, predictionModel_JP))
    acurracy_JP = accuracy_score(Y_test_JP, predictionModel_JP)
    print("Accuracy for Report for Extrovert/Introver: ", acurracy_JP, "\n")
    print("----------------------------------------------")


# Creating a model prediction with 4 models for each category

def modelPrediction(X_data, Y_data, m1, m2, m3, m4):

    # Train and Test set for each column
    X_train_IE, X_test_IE, Y_train_IE, Y_test_IE = train_test_split(
        X_data, Y_data['Extrovert/Introvert'], test_size=0.2, stratify=Y_data)
    X_train_NS, X_test_NS, Y_train_NS, Y_test_NS = train_test_split(
        X_data, Y_data['Intution/Sensation'], test_size=0.2, stratify=Y_data)
    X_train_TF, X_test_TF, Y_train_TF, Y_test_TF = train_test_split(
        X_data, Y_data['Thinking/Feeling'], test_size=0.2, stratify=Y_data)
    X_train_JP, X_test_JP, Y_train_JP, Y_test_JP = train_test_split(
        X_data, Y_data['Perception/Judgement'], test_size=0.2, stratify=Y_data)

    # Predict if they are an extrovert or introvert
    ypredEI = m1.fit(X_train_IE, Y_train_IE).best_estimator_.predict(X_test_IE)

    # Predict if they are an intution or sensation
    ypredIS = m2.fit(X_train_NS, Y_train_NS).best_estimator_.predict(X_test_NS)

    # Predict if they are thinking or feeling
    ypredTF = m3.fit(X_train_TF, Y_train_TF).best_estimator_.predict(X_test_TF)

    # Predict if they are perception or judgement
    ypredPF = m4.fit(X_train_JP, Y_train_JP).best_estimator_.predict(X_test_JP)

    return ypredEI, ypredIS, ypredPF, ypredTF


def naiverModel(X_data, Y_data):

    # Naive Bayes Model
    naivegb = GaussianNB()

    # Apply stratified cross validation
    grid1 = GridSearchCV(naivegb, {}, cv=5)
    grid2 = GridSearchCV(naivegb, {}, cv=5)
    grid3 = GridSearchCV(naivegb, {}, cv=5)
    grid4 = GridSearchCV(naivegb, {}, cv=5)

    # prediction
    ypredIE, ypredNS, ypredTF, ypredJP = modelPrediction(
        X_data, Y_data, grid1, grid2, grid3, grid4)

    return ypredIE, ypredNS, ypredTF, ypredJP


# How will we predict the user's personality ?
# By having an array called test_input where indexes 0 - 4 are training data from the myers briggs dataframe and index 5 is the user's input we are are predicting
# These examples have to be pre-processed

def predictingUser(userText, dataframe):

    test_input = []

    # NEED 4 training posts and 1 testing
    test_input.append(dataframe.iloc[0]["posts"])
    test_input.append(dataframe.iloc[1]["posts"])
    test_input.append(dataframe.iloc[2]["posts"])
    test_input.append(dataframe.iloc[3]["posts"])
    test_input.append(dataframe.iloc[4]["posts"])
    test_input.append(userText)

    # Vectorize this array to be 0 and 1 in a matrix
    test_tf_vector, Y_data = vectorization(test_input, dataframe)

    return test_x_data, Y_data

# Change the user's 0/1 to the actual personaility


def finalPrediction(ypredIE, ypredNS, ypredTF, ypredJP):

    user_myerbriggs = " "

    if (ypredIE[5] == 1):
        user_myerbriggs += "E"
    else:
        user_myerbriggs += "I"

    if (ypredNS[5] == 1):
        user_myerbriggs += "S"
    else:
        user_myerbriggs += "I"

    if (ypredTF[5] == 1):
        user_myerbriggs += "F"
    else:
        user_myerbriggs += "T"

    if (ypredJP[5] == 1):
        user_myerbriggs += "J"
    else:
        user_myerbriggs += "P"

    return user_myerbriggs


def main():
    myersBrigs_df = readDatFrame()
    personailtyColumns(myersBrigs_df)
    dataPreprocessing(myersBrigs_df)
    # print(myersBrigs_df)
    #df_list = setProcessList(myersBrigs_df)
    #X_data, Y_data = vectorization(df_list, myersBrigs_df)
    # x_data, y_data = vectorization(df_list, myersBrigs_df)
    x_data, y_data = predictingUser("userText", myersBrigs_df)
    ypredEI, ypredIS, ypredPF, ypredTF = modelPrediction(x_data, y_data)
    user_16_personailty = finalPrediction(ypredEI, ypredIS, ypredPF, ypredTF)
    print(user_16_personailty)


if __name__ == "__main__":
    main()
