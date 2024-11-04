import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    return Habit(
      id: reader.readString(),
      imagePath: reader.readString(),
      title: reader.readString(),
      description: reader.read(),
      number: reader.readInt(),
      startDate: reader.read(),
      isTapped: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.imagePath);
    writer.writeString(obj.title);
    writer.write(obj.description);
    writer.writeInt(obj.number);
    writer.write(obj.startDate);
    writer.writeBool(obj.isTapped);
  }
}
