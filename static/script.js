window.onload = () => {
    fetch('/capture')
      .then(res => res.text())
      .then(msg => console.log(msg))
      .catch(err => console.error(err));
};
