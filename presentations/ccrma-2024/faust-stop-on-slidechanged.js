Reveal.on( 'slidechanged', () => document.querySelectorAll('faust-editor')
	   .forEach(f => f.shadowRoot.querySelector('#stop')
		    .dispatchEvent(new Event('click'))))
