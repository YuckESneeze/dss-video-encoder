DSS VIDEO ENCODER - RENDER VERSION
==================================

WHAT THIS DOES
--------------
This runs the Roblox DSS video encoder online on Render.

After it is deployed:
- Dad's PC can be off.
- No Cloudflare CMD window.
- No local Python encoder CMD window.
- Roblox talks directly to your permanent Render URL.
- GottaBeHalloween.mp4 is already included.

FILES
-----
Dockerfile
render.yaml
videos/GottaBeHalloween.mp4

STEP 1 - MAKE A GITHUB REPOSITORY
---------------------------------
Go to:
https://github.com/new

Make a repository, for example:
dss-video-encoder

It can be Private if your Render account can access your private GitHub repos.

Upload the CONTENTS of this extracted folder to the repository:
  Dockerfile
  render.yaml
  .gitignore
  README_FIRST.txt
  videos/GottaBeHalloween.mp4

IMPORTANT:
GottaBeHalloween.mp4 is about 79 MB, which is below GitHub's normal
100 MB single-file web upload limit.

STEP 2 - CREATE THE RENDER SERVICE
----------------------------------
Go to:
https://dashboard.render.com/

Click:
New +  ->  Blueprint

Connect the GitHub repository you just made.

Render reads render.yaml automatically.

If you instead choose "Web Service":
- Runtime: Docker
- Health Check Path: /health
- The Dockerfile handles the start command.

STEP 3 - WAIT FOR THE BUILD
---------------------------
The first build can take a few minutes because Render installs:
- Debian FFmpeg
- Python
- the Roblox video encoder

Wait until Render says the service is Live.

STEP 4 - COPY THE RENDER URL
----------------------------
It should look roughly like:

https://dss-video-encoder-xxxx.onrender.com

Open:

https://YOUR-ADDRESS.onrender.com/health

You should see:

{"ok":true}

STEP 5 - SEND THE URL BACK IN CHAT
----------------------------------
Send the full https://....onrender.com address back to ChatGPT.

Then your DSS can be rebuilt with that URL permanently baked in.

HOW YOUR CURRENT HALLOWEEN MAPPING WORKS
---------------------------------------
Your current DSS requests:

C:\DSS Videos\GottaBeHalloween.mp4

The Render Docker image creates a symlink with that exact filename pointing to:

/videos/GottaBeHalloween.mp4

So you do not need to rename or change the Halloween mapping yet.

ADDING MORE VIDEOS LATER
------------------------
Add another MP4 into the videos folder, then add another symlink line
to the Dockerfile (or we can improve the encoder to accept just filenames).

FREE RENDER NOTE
----------------
Render's free web service can spin down after being idle.
The first show request after a long idle period may need time for the
service to wake up. An always-on paid Render instance avoids that.

SOURCE
------
Encoder:
https://github.com/bruvie-fr/roblox-video-player

The encoder project's license is MIT with Commons Clause. Keep its
copyright/license requirements when using or redistributing it.
