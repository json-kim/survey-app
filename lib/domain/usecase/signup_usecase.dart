import 'package:survey_app/domain/model/member/member.dart';
import 'package:survey_app/domain/repository/member_repository.dart';

import 'usecase.dart';

class SignupUseCase implements UseCase<bool, Member> {
  final MemberRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<bool> call(Member member) async {
    final result = await _repository.signup(member);

    return result;
  }
}