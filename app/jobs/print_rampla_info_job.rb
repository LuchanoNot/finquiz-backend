class PrintRamplaInfoJob < ApplicationJob
  queue_as :default

  def perform
    puts "Rampla Juniors Football Club, popularmente llamado como Rampla Juniors,
      es un club de fútbol uruguayo con sede en la Villa del Cerro,
      ciudad de Montevideo, nacido en la Aduana de Montevideo."
  end
end
