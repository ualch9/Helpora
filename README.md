# Helpora

**Disclaimer: This is a work in progress. The content below are the objective features for this project. Not all features listed below have been implemented.**

## About
The purpose of Helpora is to provide a help and support infrastructure with minimal steps. It is meant to be an open-source multi-platform replacement for [Apple's Help Viewer](https://developer.apple.com/library/archive/documentation/Carbon/Conceptual/ProvidingUserAssitAppleHelp/user_help_intro/user_assistance_intro.html).

Helpora is designed to work with the developer's workflow, there are 3 ways Helpora obtains help documents:
1. Bundled within the app's bundle.
2. Remotely from server.
3. Remotely from server with offline support.

All help documents are Markdown documents ([CommonMark spec](https://spec.commonmark.org/)) located in JSON files. These JSON files can be created manually using the specs located later in this README.

Remotely from server:
Load JSON from a specific server location.
To enable offline support, `index.json` and the specific page must have:
- `expiry` attribute in the form of `ISO 6801`.
- `remote_url` attribute in the form of `URL`.

The purpose of the `expiry` attribute is to let the client know when it should update from the server.
Helpora will not check the server for a new version if the page has not expired yet in the interest of providing a fast experience for the user. Please keep this in mind when deciding expiration times.

## License

Copyright 2019 Alan Chu 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
