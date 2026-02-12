var observer = new IntersectionObserver(function(entries) {
  entries.forEach(function(entry) {
    if (entry.isIntersecting) {
      entry.target.classList.add('lr-visible');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.15 });
document.querySelectorAll('.lr-fade-in').forEach(function(el) { observer.observe(el); });
document.querySelectorAll('.lr-stagger').forEach(function(el) { observer.observe(el); });

document.querySelector('.lr-menu-btn').addEventListener('click', function() {
  document.querySelector('.lr-header').classList.toggle('lr-menu-open');
});

document.querySelectorAll('.lr-nav a').forEach(function(link) {
  link.addEventListener('click', function() {
    document.querySelector('.lr-header').classList.remove('lr-menu-open');
  });
});

document.querySelectorAll('.lr-faq-question').forEach(function(btn) {
  btn.addEventListener('click', function() {
    var item = this.closest('.lr-faq-item');
    var isActive = item.classList.contains('active');
    document.querySelectorAll('.lr-faq-item').forEach(function(i) { i.classList.remove('active'); });
    if (!isActive) item.classList.add('active');
  });
});
