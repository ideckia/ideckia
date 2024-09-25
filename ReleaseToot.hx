class ReleaseToot {
	static function main() {
		#if (mastobot_token && ideckia_version)
		var mastodonToken = haxe.macro.Context.definedValue('mastobot_token');
		var ideckiaVersion = haxe.macro.Context.definedValue('ideckia_version');

		var changelog = sys.io.File.getContent('changelog.md');
		var endpoint = 'https://fosstodon.org/api/v1/statuses';

		var http = new sys.Http(endpoint);
		http.addHeader('Authorization', 'Bearer ' + mastodonToken);
		http.addHeader("Content-type", "application/json");

		var releaseNotes = 'Ideckia ${ideckiaVersion} released!\n\n';
		releaseNotes += 'Get it from https://ideckia.github.io\n';
		releaseNotes += 'These are the changes:\n\n$changelog';
		if (releaseNotes.length > 500)
			releaseNotes = releaseNotes.substr(0, 400) + '...\n\nFull changelog: https://github.com/ideckia/ideckia/blob/master/changelog.md';

		http.setPostData(haxe.Json.stringify({
			status: releaseNotes
		}));

		http.onError = (e) -> trace('errorea: $e');

		http.request(true);

		trace(http.responseData);
		#else
		trace('"-D mastobot_token" and "-D ideckia_version" are mandatory.');
		#end
	}
}
