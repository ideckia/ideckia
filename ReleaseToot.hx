class ReleaseToot {
	static function main() {
		#if (mastodon_token && ideckia_version)
		var mastodonToken = haxe.macro.Context.definedValue('mastodon_token');
		var ideckiaVersion = haxe.macro.Context.definedValue('ideckia_version');

		var changelog = sys.io.File.getContent('changelog.md');
		var endpoint = 'https://fosstodon.org/api/v1/statuses';

		var http = new sys.Http(endpoint);
		http.addHeader('Authorization', 'Bearer ' + mastodonToken);
		http.addHeader("Content-type", "application/json");

		var releaseNotes = 'Ideckia ${ideckiaVersion} released!\n\n';
		releaseNotes += 'Get it from https://ideckia.github.io\n';
		releaseNotes += 'These are the changes:\n\n$changelog';

		http.setPostData(haxe.Json.stringify({
			status: releaseNotes
		}));

		http.onError = (e) -> trace('errorea: $e');

		http.request(true);

		trace(http.responseData);
		#else
		trace('"-D mastodon_token" and "-D ideckia_version" are mandatory.');
		#end
	}
}