import Foundation

/// Узел линейного двунаправленного  списка.
class Node<T> {
    var value: T

    var next: Node<T>?
    var prev: Node<T>?

    init(_ value: T, prev: Node<T>? = nil, next: Node<T>? = nil) {
        self.value = value
        self.prev = prev
        self.next = next
    }
}

/// Линейный однонаправленный список.
public struct DoublyLinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?

    private(set) var count = 0

    /// Возвращает логическое значение, определяющее, пуст ли список.
    /// Сложность O(n).
    var isEmpty: Bool {
        head == nil
    }

    /// Инициализатор списка.
    /// - Parameter value: Значение, которое будет добавлено в список.
    init(value: T? = nil) {
        if let value = value {
            push(value)
        }
    }

    /// Добавление в начало списка значения.
    ///
    /// Сложность O(1).
    /// - Parameter value: Значение, которое будет добавлено в список.
    mutating func push(_ value: T) {
        let newHead = Node(value, next: head)
        head?.prev = newHead
        head = newHead

        if tail == nil {
            tail = head
        }

        count += 1
    }

    /// Добавление в конец списка значения.
    ///
    /// Сложность O(1).
    /// - Parameter value: Значение, которое будет добавлено в список.
    mutating func append(_ value: T) {
        let node = Node(value)

        tail?.next = node
        node.prev = tail
        tail = node

        if head == nil {
            head = tail
        }

        count += 1
    }

    /// Вставка в середину списка значения.
    ///
    /// Сложность O(n).
    /// - Parameters:
    ///   - value: Значение, которое будет вставлено в список;
    ///   - index: Индекс, после которого будет вставлено значение.
    mutating func insert(_ value: T, after index: Int) {
        guard let node = node(at: index) else { return }
        guard node !== tail else {
            append(value)
            return
        }

        let newNode = Node(value, prev: node, next: node.next)
        node.next?.prev = newNode
        node.next = newNode

        count += 1
    }

    /// Извлечение значения из начала списка.
    ///
    /// Сложность O(1).
    /// - Returns: Извлеченное из списка значение.
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        defer {
            head = head?.next
            head?.prev = nil

            if head == nil {
                tail = nil
            }

            count -= 1
        }

        return head?.value
    }

    /// Извлечение значения c конца списка.
    ///
    /// Сложность O(n).
    /// - Returns: Извлеченное из списка значение.
    mutating func removeLast() -> T? {
        guard !isEmpty else { return nil }

        defer {
            tail = tail?.prev
            tail?.next = nil

            if tail == nil {
                head = nil
            }

            count -= 1
        }

        return tail?.value
    }

    /// Извлечение значения из середины списка.
    /// - Parameter index: Индекс, после которого надо извлеч значение.
    /// - Returns: Извлеченное из списка значение.
    mutating func remove(after index: Int) -> T? {
        guard let node = node(at: index) else { return nil }
        guard node !== tail else { return nil }

        defer {
            if node.next === tail {
                tail = node
            }

            node.next = node.next?.next
            node.next?.prev = node
            count -= 1
        }

        return node.next?.value
    }
}


private extension DoublyLinkedList {

    /// Возвращает узел списка по индексу.
    private func node(at index: Int) -> Node<T>? {
        guard index >= 0 && index < count else { return nil }
        
        if index < count / 2 {
            var currentIndex = 0
            var currentNode = head

            while currentNode != nil && currentIndex < index {
                currentNode = currentNode?.next
                currentIndex += 1
            }

            return currentNode
        } else {
            var currentIndex = count - 1
            var currentNode = tail

            while currentNode != nil && currentIndex > index {
                currentNode = currentNode?.prev
                currentIndex -= 1
            }

            return currentNode
        }
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        "\(value)"
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var values = [String]()
        var current = head

        while current != nil {
            values.append("\(current!)")
            current = current?.next
        }

        return values.joined(separator: " -> ")

    }
}

