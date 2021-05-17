function colorRating() {
  const ratings = document.querySelectorAll(".rating");
  ratings.forEach((rating) => {
    if(rating.innerText >= 8) {
      rating.classList.add('green')
    } else if(rating.innerText >= 5) {
      rating.classList.add('orange')
    } else {
      rating.classList.add('red')
    }
  });
};

colorRating();
