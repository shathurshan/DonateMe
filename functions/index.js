const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore
  .document('events/{event}')
  .onCreate((Snapshot, context) => {

return admin.messaging().sendTopic('events',{notification: {title: Snapshot.data().name,body:Snapshot.data().dis,},clickAction:'FLUTTER_NOTIFICATION_CLICK'});


  });