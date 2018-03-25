The purpose of Helpora is to provide a help and support infrastructure with minimal steps.

Helpora is designed to work with the developer's workflow, there are 3 ways Helpora obtains help documents:
1. Bundled within the app's bundle.
2. Remotely from server.
3. Remotely from server with offline support.

All help documents are Markdown documents (CommonMark) located in JSON files. These JSON files can be created manually using the specs located later in this README, or using the HelporaMutator macOS app.

Remotely from server:
Load JSON from a specific server location.
To enable offline support, `index.json` and the specific page must have:
- `expiry` attribute in the form of `ISO 6801`.
- `remote_url` attribute in the form of `URL`.

The purpose of the `expiry` attribute is to let the client know when it should update from the server.
Helpora will not check the server for a new version if the page has not expired yet in the interest of providing a fast experience for the user. Please keep this in mind when deciding expiration times.
