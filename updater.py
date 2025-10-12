from dotenv import load_dotenv
from os import environ, path as ospath
from subprocess import run as urun

load_dotenv("config.env", override=True)

UPSTREAM_REPO = environ.get("UPSTREAM_REPO")
UPSTREAM_BRANCH = environ.get("UPSTREAM_BRANCH", "main")
if not UPSTREAM_REPO:
    exit(1)

if ospath.exists("bot-code"):
    urun("rm -rf bot-code", shell=True)

clone_cmd = f"git clone -b {UPSTREAM_BRANCH} {UPSTREAM_REPO} bot-code"
res = urun(clone_cmd, shell=True)
if res.returncode != 0:
    exit(1)
