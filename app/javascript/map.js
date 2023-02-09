function initMap() {
  const coords = document.getElementById("routes");
  const city = {
    lat: parseFloat(coords.getAttribute("data-latitude")),
    lng: parseFloat(coords.getAttribute("data-longitude"))
  };
  console.log(city)

  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 12,
    center: city,
    disableDefaultUI: true,
  });

  const routes = document.querySelectorAll("div.route-list");

  routes.forEach(route => {


    const coords = route.querySelectorAll("div.route-list-item");
    const triangleCoords = []

    coords.forEach((coord, index) => {
      triangleCoords.push({lat: parseFloat(coord.getAttribute("data-latitude")),
        lng: parseFloat(coord.getAttribute("data-longitude"))
      })
      const marker = new google.maps.Marker({
        position: {
          lat: parseFloat(coord.getAttribute("data-latitude")),
          lng: parseFloat(coord.getAttribute("data-longitude"))
        },
        map: map,
        label: String(index + 1)
      });
    })

    const bermudaTriangle = new google.maps.Polygon({
      paths: triangleCoords,
      strokeColor: "#FF0000",
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: "green",
      fillOpacity: 0.35,
    });
    bermudaTriangle.setMap(map);
  })
}

window.initMap = initMap;
