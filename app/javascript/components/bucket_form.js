function show_hide(id){
  var form = document.getElementById(id);//se define la variable "form" igual a nuestro div
  form.style.display = (form.style.display == 'none') ? 'block' : 'none'; //damos un atributo display:none que oculta el div
};

const initShowBucketForm = () => {
  var bucketForm = document.getElementById("show-form")
  if (bucketForm) {
    document.getElementById("show-form").addEventListener("click",(event) => {
     show_hide("form");
    });
  }
};

export { initShowBucketForm };