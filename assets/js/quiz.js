(function () {
  const container = document.getElementById('quiz-container');
  if (!container) return;

  const questionsWrap = document.getElementById('quiz-questions');
  const summaryEl = document.getElementById('quiz-summary');
  const scoreEl = document.getElementById('quiz-score');
  const restartBtn = document.getElementById('quiz-restart');
  const items = Array.from(container.querySelectorAll('.quiz-item'));
  const progress = document.getElementById('quiz-progress');
  const prevBtn = document.getElementById('quiz-prev');
  const nextBtn = document.getElementById('quiz-next');
  let current = 0;

  function updateNav() {
    const isLast = current === items.length - 1;
    prevBtn.disabled = current === 0;
    nextBtn.disabled = !items[current].classList.contains('answered');
    nextBtn.textContent = isLast ? 'Vyhodnotiť →' : 'Ďalšia →';
  }

  function showItem(index) {
    items.forEach((item, i) => item.classList.toggle('active', i === index));
    progress.textContent = 'Otázka ' + (index + 1) + ' / ' + items.length;
    updateNav();
  }

  function answerItem(item, btn, correct) {
    if (item.classList.contains('answered')) return;
    item.classList.add('answered');

    const chosen = btn.classList.contains('quiz-yes') ? 'yes' : 'no';
    const isCorrect = chosen === correct;
    item.dataset.result = isCorrect ? 'correct' : 'incorrect';
    btn.classList.add(isCorrect ? 'correct' : 'incorrect');

    if (!isCorrect) {
      const correctBtn = item.querySelector(correct === 'yes' ? '.quiz-yes' : '.quiz-no');
      correctBtn.classList.add('correct');
    }

    item.querySelectorAll('.quiz-btn').forEach((b) => { b.disabled = true; });
    item.querySelector('.quiz-comment').classList.add('visible');
    updateNav();
  }

  items.forEach((item) => {
    const correct = item.dataset.correct;
    item.querySelectorAll('.quiz-btn').forEach((btn) => {
      btn.addEventListener('click', () => answerItem(item, btn, correct));
    });
  });

  function showSummary() {
    const score = items.filter((item) => item.dataset.result === 'correct').length;
    scoreEl.textContent = score + ' / ' + items.length;
    questionsWrap.style.display = 'none';
    summaryEl.classList.add('visible');
  }

  function resetQuiz() {
    items.forEach((item) => {
      item.classList.remove('answered');
      delete item.dataset.result;
      item.querySelectorAll('.quiz-btn').forEach((b) => {
        b.disabled = false;
        b.classList.remove('correct', 'incorrect');
      });
      item.querySelector('.quiz-comment').classList.remove('visible');
    });
    summaryEl.classList.remove('visible');
    questionsWrap.style.display = '';
    current = 0;
    showItem(current);
  }

  prevBtn.addEventListener('click', () => {
    if (current > 0) {
      current -= 1;
      showItem(current);
    }
  });

  nextBtn.addEventListener('click', () => {
    if (current === items.length - 1) {
      showSummary();
      return;
    }
    current += 1;
    showItem(current);
  });

  restartBtn.addEventListener('click', resetQuiz);

  showItem(current);
})();
