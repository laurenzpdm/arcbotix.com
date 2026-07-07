document.getElementById('blogSearch').addEventListener('input', function() {
  var q = this.value.toLowerCase().trim();
  var cards = document.querySelectorAll('.blog-grid .blog-card');
  var visible = 0;
  cards.forEach(function(card) {
    var text = card.textContent.toLowerCase();
    var match = !q || text.indexOf(q) !== -1;
    card.hidden = !match;
    if (match) visible++;
  });
  var noResults = document.getElementById('blogNoResults');
  noResults.classList.toggle('visible', visible === 0 && q.length > 0);
});
