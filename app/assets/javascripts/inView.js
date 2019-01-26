function inView(panel, icon) {
  let diff = panel.getBoundingClientRect().top - icon.getBoundingClientRect().top;

  if (diff === -25) {
    return true
  } else {
    return false
  };
}
