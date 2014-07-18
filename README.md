Paranoia password manager
=========================

A lightweight password manager that everyone can host on their own and use on any device

# Intro

Paranoia password manager is a an HTML5 password manager that syncs your passwords securely between all your devices. Syncing is achieved using [Dropbox Datastores API](https://www.dropbox.com/developers/datastore) and your credentials are encrypted client side using [TripleSec](https://keybase.io/triplesec/triplesec_now_in_python.html).

You can try [Our hosted version](https://dl.dropboxusercontent.com/u/57398301/paranoia_password_manager/index.html) or host it yourself (see instructions below).

# Developing

First, you need to make sure you have [npm](https://www.npmjs.org/) installed. Then, you need [brunch](http://brunch.io/) and [bower](http://bower.io/):

    npm install -g brunch
    npm install -g bower

After checking out the project, do the following to set it up:

    npm install
    bower install

You can now start a dev server and navigate your browser to the address it gives you (by default it's `http://localhost:3333/`)

    brunch watch --server

# Hosting

You can host the password manager anywhere by downloading [the latest version](https://www.dropbox.com/s/1z82tavmkbiqnsm/paranoia%20password%20manager.zip?dl=0) or building it and copying the content of `/public`.

## Dropobx Datastores

In order to make it work with Dropbox Datastores, you have to create a new Dropbox app and replacing the app key in `/app/router.coffee: initDropboxDatastores()` with your app key.

## Hosting in a Dropbox Public folder

An easy way to host on your own is to copy the `/public` folder into your Dropbox `Public` folder and getting a link to the `index.html` file