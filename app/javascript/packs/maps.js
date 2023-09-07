import 'leaflet/dist/leaflet.css';
import { icon } from 'leaflet';
import L from 'leaflet';

// Webpackerを使用している場合に発生するアイコンの問題を解消
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  // アイコンとその他のマーカーの画像へのパスを修正
  iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
  iconUrl: require('leaflet/dist/images/marker-icon.png'),
  shadowUrl: require('leaflet/dist/images/marker-shadow.png')
});

// 地図を初期化する関数
function initializeMap(mapElement, latitude = 35.6895, longitude = 139.6917, zoomLevel = 13) {
  const map = L.map(mapElement).setView([latitude, longitude], zoomLevel);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  return map;
}

// 地図にマーカーを追加する関数
function addMarkerToMap(map, latitude, longitude, popupText = '') {
  L.marker([latitude, longitude]).addTo(map)
    .bindPopup(popupText).openPopup();
}

// ドキュメントが読み込まれたら地図を初期化
document.addEventListener("DOMContentLoaded", () => {
  const map = initializeMap('mapid');

  // すべての地図データを読み込んでマーカーを追加する
if (window.mapsData) {
  window.mapsData.forEach((mapData) => {
    addMarkerToMap(map, mapData.latitude, mapData.longitude, `
      <b>${mapData.spot_name}</b>
      <p>${mapData.description}</p>
      <img src="${mapData.snap}" width="100" />
    `);
  });
}
  // ユーザーの現在位置を取得してマーカーを設置し、座標を隠しフィールドに設定する
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;

      // マーカーを追加
      addMarkerToMap(map, latitude, longitude, 'Your current location');

      // HTMLフォームの対応するフィールドに値を設定する
      const latField = document.querySelector('#post_latitude');
      const lngField = document.querySelector('#post_longitude');

      if (latField && lngField) {
        latField.value = latitude;
        lngField.value = longitude;
      }
    });
  }
});

// initializeMapとaddMarkerToMap関数をエクスポート（他のファイルから利用可能にする）
export { initializeMap, addMarkerToMap };
