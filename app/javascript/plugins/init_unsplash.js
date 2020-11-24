const accesKey = UvGYG8Rd6LMh9z2nViNGDXeh3ReiGP7aEri3K5c4PfI;

const endPoint = 'https://api.unsplash.com/search/photos';

async function getImages(query){
  let response = await fetch(endPoint + '?query=' + query + '&client_id=' + accesKey);
  let jsonResponse = await response.json();
  let imagesList = await jsonResponse.results;
}