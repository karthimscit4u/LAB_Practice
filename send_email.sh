#!/bin/bash

# === INPUT ARGS ===
TO_EMAIL="$1"
SUBJECT="$2"
ATTACHMENT_PATH="$3"

# === LOAD CONFIG ===
CONFIG_FILE="./mail_config.conf"
TEMPLATE_FILE="./email_template.txt"

[[ ! -f "$CONFIG_FILE" ]] && echo "Missing config." && exit 1
[[ ! -f "$TEMPLATE_FILE" ]] && echo "Missing template." && exit 1

source "$CONFIG_FILE"
BODY=$(cat "$TEMPLATE_FILE")
EMAIL_FILE="/tmp/email_$(date +%s).txt"

# === BUILD EMAIL ===
if [[ -f "$ATTACHMENT_PATH" ]]; then
  BOUNDARY="====BOUNDARY_$(date +%s)==="
  {
    echo "Subject: $SUBJECT"
    echo "From: $FROM_EMAIL"
    echo "To: $TO_EMAIL"
    echo "MIME-Version: 1.0"
    echo "Content-Type: multipart/mixed; boundary=\"$BOUNDARY\""
    echo
    echo "--$BOUNDARY"
    echo "Content-Type: text/plain"
    echo
    echo "$BODY"
    echo
    echo "--$BOUNDARY"
    echo "Content-Type: application/octet-stream; name=\"$(basename "$ATTACHMENT_PATH")\""
    echo "Content-Transfer-Encoding: base64"
    echo "Content-Disposition: attachment; filename=\"$(basename "$ATTACHMENT_PATH")\""
    echo
    base64 "$ATTACHMENT_PATH"
    echo "--$BOUNDARY--"
  } > "$EMAIL_FILE"
else
  {
    echo "Subject: $SUBJECT"
    echo "From: $FROM_EMAIL"
    echo "To: $TO_EMAIL"
    echo
    echo "$BODY"
  } > "$EMAIL_FILE"
fi

# === SEND EMAIL ===
curl --url "smtp://$SMTP_SERVER:$SMTP_PORT" \
     --ssl-reqd \
     --mail-from "$FROM_EMAIL" \
     --mail-rcpt "$TO_EMAIL" \
     --user "$SMTP_USER:$SMTP_PASS" \
     --upload-file "$EMAIL_FILE" \
     --insecure

rm -f "$EMAIL_FILE"

