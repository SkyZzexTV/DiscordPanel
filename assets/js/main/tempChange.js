/**
 * @file tempChange.js
 * @author SkyZzexTV
 * @license GPL-3.0
 */

function tempChange(DOM, text, time) {
	let newText = `${$(DOM).text().replace(text, "")} ${text}`;

	$(DOM).html(newText);

	setTimeout(() => {
		$(DOM).html(newText.replace(text, ""));
	}, time);
}
