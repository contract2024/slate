function copyToClipboard(container) {
  const el = document.createElement('textarea');
  el.value = container.textContent.replace(/\n$/, '');
  document.body.appendChild(el);
  el.select();
  document.execCommand('copy');
  document.body.removeChild(el);
}

function setupCodeCopy() {
  
  // $('pre.highlight').prepend('<div class="copy-clipboard"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Copy to Clipboard</title><path d="M18 6v-6h-18v18h6v6h18v-18h-6zm-12 10h-4v-14h14v4h-10v10zm16 6h-14v-14h14v14z"></path></svg></div>');
  $('pre.highlight').prepend('<div class="copy-clipboard"><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none"> <rect x="1" y="3" width="8" height="8" fill="#909090"/> <rect x="3" y="1" width="8" height="1" fill="#909090"/> <rect x="10" y="9" width="8" height="1" transform="rotate(-90 10 9)" fill="#909090"/></svg></div>');
  $('.copy-clipboard').on('click', function() {
    copyToClipboard(this.parentNode.children[1]);
  });
}
