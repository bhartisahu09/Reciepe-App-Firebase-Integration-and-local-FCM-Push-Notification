// web/firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyAvGDyio0fpyxHv02J-lMrCsbcWmQKz5ng",
  authDomain: "flutter-food-receipe-app.firebaseapp.com",
  projectId: "flutter-food-receipe-app",
  storageBucket: "flutter-food-receipe-app.appspot.com",
  messagingSenderId: "312488303379",
  appId: "1:312488303379:web:dfd68bb43722290bfe98e6",
});

const messaging = firebase.messaging();


// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// // For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//   apiKey: "AIzaSyBwabnOlviWndt6keh1e0CQX7bhhg6DK8k",
//   authDomain: "flutter-food-receipe-app.firebaseapp.com",
//   projectId: "flutter-food-receipe-app",
//   storageBucket: "flutter-food-receipe-app.firebasestorage.app",
//   messagingSenderId: "312488303379",
//   appId: "1:312488303379:web:dfd68bb43722290bfe98e6",
//   measurementId: "G-KX88VVY4DF"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);