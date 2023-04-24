import struct Foundation.URL

/// A structure representing a webhook configuration.
///
/// A webhook is an HTTPS URL that receives a `POST` request
/// when a prediction or training generates new output, logs,
/// or reaches a terminal state (succeeded / canceled / failed).
///
/// Example usage:
///
/// ```swift
/// let webhook = Webhook(url: someURL, events: [.start, .completed])
/// ```
public struct Webhook {
    /// The events that can trigger a webhook request.
    public enum Event: String, Hashable, CaseIterable {
        /// Occurs immediately on prediction start.
        case start

        /// Occurs each time a prediction generates an output.
        case output

        /// Occurs each time log output is generated by a prediction.
        case logs

        /// Occurs when the prediction reaches a terminal state (succeeded / canceled / failed).
        /// - SeeAlso: ``Status/terminated``
        case completed
    }

    /// The webhook URL.
    public let url: URL

    /// A set of events that trigger the webhook.
    public let events: Set<Event>

    /// Creates a new `Webhook` instance with the specified URL and events.
    ///
    /// By default, the webhook will be triggered by all event types.
    /// You can change which events trigger the webhook by specifying a
    /// sequence of events as `events` parameter.
    ///
    /// - Parameters:
    ///   - url: The webhook URL.
    ///   - events: A sequence of events that trigger the webhook.
    ///             Defaults to all event types.
    public init<S: Sequence>(
        url: URL,
        events: S = Event.allCases
    ) where S.Element == Event
    {
        self.url = url
        self.events = Set(events)
    }
}

// MARK: - CustomStringConvertible

extension Webhook.Event: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
