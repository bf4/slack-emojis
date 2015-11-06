slack-emojis
============


## Setup

You'll need Python and `pip` to get started. I recommend using [virtualenv](https://virtualenv.pypa.io/en/latest/) and possibly [virtualenvwrapper](https://virtualenvwrapper.readthedocs.org/en/latest/) as well. Standard best-practice Python stuff.

Here's a way to install python 2.7 on a mac

```bash
# brew update || echo "could not update brew: $!"
which pyenv &> /dev/null
if [ $? -ne 0 ]; then
  brew install pyenv &&
  pyenv install 2.7 &&
  pyenv global 2.7 &&
  echo 'Add to your login rc: eval "$(pyenv init -)"' &&
  eval "$(pyenv init -)"
fi
which pyenv &> /dev/null
if [ $? -eq 0 ]; then echo 'pyenv installed'; else echo 'pyenv not installed'; fi
```

### Install prerequisites
```bash
pyenv global 2.7
pip install -r requirements.txt
```

### Before upload/download

1. `cp .env.example .env`
2. edit `.env`, follow comments to configure variables
3. `source .env`

You'll need to edit the `.env` whenever switching teams.

## Bulk download emoji from Slack

```bash
python get_emojis.py -o images "${SLACK_TEAM}" "${SLACK_TOKEN}"
```

Get the token from https://api.slack.com/web

## Bulk upload emoji into Slack

Want to create a custom Slack emoji for every pokemon?

Slack doesn't currently expose an API endpoint for creating emoji, probably to prevent users
from doing exactly what I'm doing, but here's a way to do it anyway.

Prepare a directory that contains an image for each emoji you want to create.
Remember to respect Slack's specifications for valid emoji images:
no greater than 128px in width or height, no greater than 64K in image size.
The base filename of each image file should be the name of the emoji
(the bit you'll type inside `:` to display it).

You'll need to have configured the `.env` with `$SLACK_TEAM` and `$SLACK_COOKIE`

Now you're ready to go. Use a shell glob to invoke `upload.py` with the emoji files as ARGV:

```bash
source .env && python upload.py images/*
```

:sparkles:
