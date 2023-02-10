var colors = ['#3366CC', '#DC3912', '#FF9900', '#109618', '#990099', '#3B3EAC', '#0099C6', '#DD4477', '#66AA00', '#B82E2E', '#316395', '#994499', '#22AA99', '#AAAA11', '#6633CC', '#E67300', '#8B0707', '#329262', '#5574A6', '#3B3EAC'];

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

  routes.forEach((route, i) => {

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
        label: String(index + 1),
        icon:{
          path: 'm 12,2.4000002 c -2.7802903,0 -5.9650002,1.5099999 -5.9650002,5.8299998 0,1.74375 1.1549213,3.264465 2.3551945,4.025812 1.2002732,0.761348 2.4458987,0.763328 2.6273057,2.474813 L 12,24 12.9825,14.68 c 0.179732,-1.704939 1.425357,-1.665423 2.626049,-2.424188 C 16.809241,11.497047 17.965,9.94 17.965,8.23 17.965,3.9100001 14.78029,2.4000002 12,2.4000002 Z',
          fillColor: colors[i],
          fillOpacity: 1.0,
          strokeColor: colors[i],
          strokeWeight: 1,
          scale: 2,
          anchor: new google.maps.Point(12, 24),
      },
      });
    })

    const bermudaTriangle = new google.maps.Polygon({
      paths: triangleCoords,
      strokeColor: colors[i],
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: colors[i],
      fillOpacity: 0.35
    });

    attachPolygonInfoWindow(bermudaTriangle)

    function attachPolygonInfoWindow(polygon) {
        var infoWindow = new google.maps.InfoWindow();
        google.maps.event.addListener(polygon, 'mouseover', function (e) {
            infoWindow.setContent(route.getAttribute("data-name"));
            var latLng = e.latLng;
            infoWindow.setPosition(latLng);
            infoWindow.open(map);
        });
    }

    bermudaTriangle.setMap(map);
  })
}

window.initMap = initMap;
