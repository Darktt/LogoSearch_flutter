enum LogoImageFormat implements Comparable<LogoImageFormat> {
  jpg('JPG (Default)'),
  png('PNG');

  static const allValues = <LogoImageFormat>{
    jpg,
    png,
  };

  final String description;

  const LogoImageFormat(this.description);

  @override
  int compareTo(LogoImageFormat other) =>
      description.compareTo(other.description);
}
