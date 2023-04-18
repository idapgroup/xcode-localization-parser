languages=("en" "uk")

SHEET_ID={SHEET_ID}
TABLE_ID=0

rm -rf localization.csv
rm -rf Generated/

mkdir Generated

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

    curl -L -H "Authorization: Bearer $ACCESS_TOKEN" "https://docs.google.com/spreadsheets/d/$SHEET_ID/export?exportFormat=csv&gid=$TABLE_ID" > localization.csv
else
    curl -L "https://docs.google.com/spreadsheets/d/$SHEET_ID/export?exportFormat=csv&gid=$TABLE_ID" > localization.csv
fi

./StringsGenerator localization.csv "${comma_separated_languages}"
./swiftgen strings en.lproj/Localizable.strings -o Generated/L10n-Constants.swift --templatePath localization-swift5.stencil --param publicAccess=true --param languages=${comma_separated_languages}
