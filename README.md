# Xcode Localization Helper
A shell script to download a CSV file from Google Sheets and parse it into .lproj files.

This Xcode Localization Helper script is designed to streamline the process of adding localization files to your Xcode project. The script performs the following tasks:
- Downloads a CSV from the Google Sheets file containing localization strings for multiple languages.
- Parses the CSV file into separate .lproj files for each language.

By automating these tasks, this script makes it easy to keep your Xcode project's localization files up-to-date and well-organized. Simply run the script whenever you need to update your localization files based on the latest CSV file. This will save you time and ensure that your Xcode project remains properly localized across all supported languages.

## **How to use:**

**Note: You can skip steps 1-4 if you are using a public Google Sheet.**

Before using the Xcode Localization Helper script, you need to set up the Google Cloud API for your project. Follow these steps to set up the API:

1. Go to the [Google Cloud Console](https://console.cloud.google.com/) and select your project.

2. **Enable the Google Drive API:**
   
   a. Click on the hamburger menu (three horizontal lines) in the top left corner of the Google Cloud Console.
   
   b. Navigate to "APIs & Services" > "Library".
   
   c. In the search bar, search for "Google Drive API" and activate it.

3. **Create a service account and download the `credentials.json` file:**
   
   a. Go to the [Google Cloud Console IAM & Admin](https://console.cloud.google.com/iam-admin/serviceaccounts).
   
   b. Select your project from the project dropdown menu.
   
   c. Click on "Create Service Account".
   
   d. Fill in the service account details and click "Create".
   
   e. In the "Grant this service account access to project" section, add the "Editor" role for "Google Drive API". Click "Continue" and then "Done".
   
   f. On the "Service Accounts" page, find your newly created service account and click on the pencil icon to edit it.
   
   g. Go to the "Keys" tab and click on "Add Key". Select "JSON" as the key type. This will download the `credentials.json` file.
   
   h. Move the `credentials.json` file to the same directory as the script.

4. **Grant access to the Google Sheet for the service account:**
   
   a. Open the Google Sheet you want to use for localization.
   
   b. Click the "Share" button in the top right corner of the sheet.
   
   c. In the "Share with people and groups" dialog, enter the email address of the service account you created in step 3 This email address should look like `<your-service-account>@<your-project-id>.iam.gserviceaccount.com`.
   
   d. Grant the service account "Viewer" access and click "Done" to save the changes.

5. **Set up the script:**

   a. Clone or download the script from the GitHub repository.
   
   b. Open the script in a text editor and replace {SHEET_ID} with your Google Sheets ID.
   
   c. Update the languages array with the language codes you want to use.

6. **Run sript:**

    sh update-localization.sh



## **Google Sheet structure:**

   To use the script correctly, it is important to structure your Google Sheet properly. Follow these guidelines to fill up the Google Sheet:

   a. The first row should contain language codes (e.g., en, ge, uk) in each column, starting from the second column. The first column should contain the string keys.
   
   b. Each row after the first row should represent a unique string key for your localization.
   
   c. The corresponding translated strings for each language should be placed in the columns under the respective language codes.

   Example structure:

   | key        | en           | uk           |
   |------------|--------------|--------------|
   | hello      | Hello        | Вітаю        |
   | welcome    | Welcome      | Ласкаво просимо |

## **Acknowledgments:**

   The parsing script used in this project is based on the [LocalizationDemo](https://github.com/vivek-jl/LocalizationDemo) repository by Vivek Joshi. A big thank you to the author for providing a helpful script for the community.