# Import Libaries Needed
import pandas as pd

# Linked List
from collections import deque


def loadDataframes():

    # read csv files
    # To-DO: Replace this CSV file with the actual data from the app
    profile_dataset = pd.DataFrame(pd.read_csv(
        "/Users/sanzi/Desktop/school/personality dating app/datingapp/machine algo/okCupid.csv"))
    profile_dataset = profile_dataset[[
        "age", "sex", "orientation", "Personaility Type"]]

    compatible_matches_df = pd.DataFrame(pd.read_csv(
        "/Users/sanzi/Desktop/school/personality dating app/datingapp/machine algo/personailty_compatible.csv", index_col=[0]))

    # print(compatible_matches_df)
    # print("------------")
    # print(profile_dataset)

    # To-Do: Remove this once generated user ID are created
    user_id = [11, 38, 17, 10, 58, 53,
               19, 1, 2, 5, 62, 40,
               42, 7, 37, 23, 12, 30,
               8, 28, 16, 63, 6, 49,
               66, 15, 69, 13, 41, 43,
               33, 23, 44, 38, 16, 65,
               3, 4, 9, 100, 201, 620,
               999, 99, 87, 56, 35, 697, 111]

    profile_dataset["uid"] = user_id

    dating_intention = ["Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Casual", "Dating",
                        "Marriage", "Fling", "Marriage", "Fling"]

    profile_dataset["Dating Intention"] = dating_intention

    return profile_dataset, compatible_matches_df


def findPotentialMatches(profile_dataset):

    # Find the current user infomation from dating intention
    user1_infomation = profile_dataset.iloc[10]
    # print(user1_infomation)

    user1_datingIntention = user1_infomation['Dating Intention']
    # print(user1_datingIntention)

    # Find the potential matches we would loop through
    discover_df = profile_dataset[(profile_dataset["Dating Intention"] == user1_datingIntention) & (
        profile_dataset["sex"] == 'm')]

    # append the current user infomation to the discover page at index 0
    discover_df = discover_df.append(user1_infomation)

    # return the discover matches dataframe
    return discover_df

    # function to find the potential matches for current user in a sorted linked list


def findMatches(discover_df, compatible_matches_df):

    # find the lenght of the discover dataframe
    size = len(discover_df) - 1

    # for the first row which the user is a guy with the personality type of ISTP
    # if we look at the personality compatable we see that it is the first row
    # we compare every other user in profile dataset after the first row and if it is less than 2 we put it at the end of the list

    potential_matches = {}

    # the current user's infomation will be at the end of the discover dataframe
    user1_infomation = discover_df.iloc[-1]

    user1_personality = user1_infomation['Personaility Type']

    # print(user1_infomation)
    # print("---")
    # print(user1_personality)

    # find the row for that user in the personality compatable dataframe
    user1_compatable_info = compatible_matches_df[user1_personality]

    # print("-")
    # print(user1_compatable_info)

    # go through each of the profile dataset to find the potential matches compatablility
    for i in range(0, size):

        #print("--------Other user's infomation--------")
        # print(discover_df.iloc[i])

        # the potential match personality type
        other_match_personality = discover_df.iloc[i]["Personaility Type"]
        #print("Personality Type: " + other_match_personality)

        # the potential match user id
        id = discover_df.iloc[i]["uid"]
        #print("ID: " + str(id))

        # find out the ranking of compatability
        compatability_of_users = compatible_matches_df[user1_personality][other_match_personality]

        #print("The compatability score is " + str(compatability_of_users))

        # add to the dictionary using user id and ranking of compatability
        potential_matches[id] = compatability_of_users

    # print("-----------------------")
    # print(potential_matches)

    return potential_matches


def sortedMatches(matchList):

    # sort list
    potential_matches_sorted = dict(
        sorted(matchList.items(), key=lambda item: item[1], reverse=True))
    # print(potential_matches_sorted)

    # with the sorted dictonary which the first value will be the user that is the most compatable with the user0 we can use the user id as a linked list
    potential_matches_uid = deque(potential_matches_sorted.keys())

    # print(potential_matches_uid)
    return potential_matches_uid


def main():
    profile_dataset, compatible_matches_df = loadDataframes()
    discover_df = findPotentialMatches(profile_dataset)
    potential_match = findMatches(discover_df, compatible_matches_df)
    discover_users_uid = sortedMatches(potential_match)
    print(discover_users_uid)


if __name__ == "__main__":
    main()
