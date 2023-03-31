languages=("en" "uk")
SHEET_ID={SHEET_ID}
        
rm -rf localization.csv

comma_separated_languages=""

for lang in "${languages[@]}"; do
  rm -r "${lang}.lproj"
  comma_separated_languages+="${lang},"
done

comma_separated_languages=${comma_separated_languages%,}

if [ -e "./credentials.json" ]; then
    if command -v gcloud > /dev/null 2>&1; then
        echo "gcloud is installed."
    else
        curl https://sdk.cloud.google.com | bash
        exec -l $SHELL
    fi

    gcloud auth activate-service-account --key-file=credentials.json

    ACCESS_TOKEN=$(gcloud auth print-access-token --scopes=https://www.googleapis.com/auth/drive.readonly)

    curl -L -H "Authorization: Bearer $ACCESS_TOKEN" "https://www.googleapis.com/drive/v3/files/$SHEET_ID/export?mimeType=text/csv" > localization.csv
else
    curl -L https://docs.google.com/spreadsheets/d/$SHEET_ID/export?exportFormat=csv > localization.csv
fi

./StringsGenerator localization.csv "${comma_separated_languages}"
