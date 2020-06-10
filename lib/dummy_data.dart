import './models/user.dart';

var dummyUsers = [
  User(
    uid: 'u1',
    name: 'Alexa',
    gender: 'Female',
    occupation: 'Student',
    imageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    dob: DateTime.parse('1998-09-23'),
    journeys: ['j1']
  ),
  User(
    uid: 'u2',
    name: 'John',
    gender: 'Male',
    occupation: 'Doctor',
    imageUrl: 'https://static-16.sinclairstoryline.com/resources/media/b18ba64e-3a31-42f2-aa45-e91b1927c03a-b18ba64e3a3142f2aa45e91b1927c03arendition_1_JimGrimesheadshotfinal.png?1547570373818',
    dob: DateTime.parse('1989-04-03'),
    journeys: ['j3']
  ),
  User(
    uid: 'u3',
    name: 'Weasly',
    gender: 'Male',
    occupation: 'Student',
    imageUrl: 'https://pm1.narvii.com/6707/89127fd49ab28bed5009b4a0dee5d08fcd26bd4b_hq.jpg',
    dob: DateTime.parse('1999-07-12'),
    journeys: ['j2']
  ),
  User(
    uid: 'u4',
    name: 'Harry',
    gender: 'Male',
    occupation: 'Student',
    imageUrl: 'https://s3.amazonaws.com/tinycards/image/fb7b32ea72330a9c944c788eed9bcd05',
    dob: DateTime.parse('1997-02-09'),
    journeys: ['j4']
  ),
  User(
    uid: 'u5',
    name: 'Marry',
    gender: 'Female',
    occupation: 'Advocate',
    imageUrl: 'https://i.pinimg.com/736x/e5/66/11/e5661118c8984dd62fc0cf5642598ea7.jpg',
    dob: DateTime.parse('1991-01-30'),
    journeys: ['j5']
  ),
];