import './models/user.dart';

var dummyUsers = [
  User(
    uid: 'u1',
    name: 'Alexa',
    phoneNumber: '9123850232',
    email: 'test123@gmail.com',
    gender: 'Female',
    occupation: 'Student',
    imageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    dob: DateTime.parse('1998-09-23'),
    journeys: ['j1', 'j2', 'j3', 'j4', 'j5']
  ),
  User(
    uid: 'u2',
    name: 'Weasly',
    phoneNumber: '8673245613',
    email: 'test@gmail.com',
    gender: 'Male',
    occupation: 'Student',
    imageUrl: 'https://pm1.narvii.com/6707/89127fd49ab28bed5009b4a0dee5d08fcd26bd4b_hq.jpg',
    dob: DateTime.parse('1999-07-12'),
    journeys: ['j2']
  )
];