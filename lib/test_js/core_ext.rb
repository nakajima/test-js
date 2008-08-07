unless :to_proc.respond_to?(:to_proc)
  class Symbol
    def to_proc
      proc { |*args| args.shift.send(self, *args) }
    end
  end
end
