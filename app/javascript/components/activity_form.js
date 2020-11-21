function show_hide(id){
  if (document.getElementById){ //se obtiene el id
  var form = document.getElementById(id); //se define la variable "form" igual a nuestro div
  form.style.display = (form.style.display == 'none') ? 'block' : 'none'; //damos un atributo display:none que oculta el div
  }
};

const initShowFormActivityPage = () => {
  document.getElementById("show-from-activity-page").addEventListener("click",(event) => {
   show_hide("from-activity-page")
  });
};

export { initShowFormActivityPage };