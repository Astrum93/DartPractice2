abstract interface class Command {
  void execute();
  /// 실행 취소
  void undo();
  /// undo() 번복
  void redo();
}

class SaveCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }
}

class OpenCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }
}

class CopyCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }
}
