import 'package:survey_app/data/data_source/member_fake_data_source.dart';
import 'package:survey_app/domain/model/member/member.dart';
import 'package:survey_app/domain/repository/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberFakeDataSource _dataSource;

  MemberRepositoryImpl(this._dataSource);

  @override
  Future<bool> getAuth(Member member) async {
    final result = await _dataSource.checkAuth(member);
    return result;
  }

  @override
  Future<bool> login(Member member) async {
    final result = await _dataSource.checkAuth(member);
    return result;
  }

  @override
  Future<bool> signup(Member member) async {
    final result = await _dataSource.checkAuth(member);
    return result;
  }
}
