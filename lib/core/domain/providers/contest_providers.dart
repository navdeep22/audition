import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:flutter/material.dart';

class ContestProviders extends ChangeNotifier {
  List<ChallengesModel>? _getChallenges;

  List<ChallengesModel>? get getChallenges => _getChallenges;

  setChallenges(List<ChallengesModel>? challenges) {
    _getChallenges = challenges;
    notifyListeners();
  }

  updateChallenges(List<ChallengesModel>? challenges) {
    _getChallenges = challenges;
    notifyListeners();
  }
}
