// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
	static targets = [ "passwordInput", "readPasswordInput", "readPasswordButton", "passwordButton" ];

	connect() {

	}

	generateAndCopyPassword() {
		const password = this.generatePassword();
		this.passwordInputTarget.value = password;
		this.copyToClipboard(this.passwordInputTarget);
		this.showCopiedNotification(this.passwordButtonTarget);
	}
	generateAndCopyReadPassword() {
		const password = this.generatePassword();
		this.readPasswordInputTarget.value = password;
		this.copyToClipboard(this.readPasswordButtonTarget);
		this.showCopiedNotification(this.readPasswordButtonTarget);
	}

	generatePassword() {
		var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOP1234567890";
		var pass = "";
		for (var x = 0; x < 12; x++) {
			var i = Math.floor(Math.random() * chars.length);
			pass += chars.charAt(i);
		}
		return pass;
	}

	copyToClipboard(target) {
		target.select();
		document.execCommand('copy');
	}

	showCopiedNotification(target) {
		const oldText = target.textContent;
		target.textContent = 'Copied!';
		setTimeout(() => target.textContent = oldText, 1000)
	}
}
