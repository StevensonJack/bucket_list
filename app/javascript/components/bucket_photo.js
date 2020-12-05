function show_hide(id){
  var form = document.getElementById(id); //se define la variable "form" igual a nuestro div
  form.style.display = (form.style.display == 'none') ? 'block' : 'none'; //damos un atributo display:none que oculta el div
};

const initShowBucketPhoto = () => {
  var showPhoto = document.getElementById("show-bucket-photo");
  if (showPhoto){
    showPhoto.addEventListener("click",(event) => {
     show_hide("upload-photo-form");
    });
  }
};

export { initShowBucketPhoto };